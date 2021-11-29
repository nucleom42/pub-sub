RSpec.shared_examples 'pub sub' do

  class PubKlass
    include PubSub::Publisher

    def publish
      self.class.pub('event', { message: 'published' })
    end
  end

  class SubKlass
    include PubSub::Subscriber

    def self.call(args)
      args[:message]
    end
  end

  module Piu
    class SubKlass2
      include PubSub::Subscriber

      def self.call(args)
        args[:message] + '2'
      end
    end
  end

  context 'when there are two subscriber to the same event' do
    before do
      SubKlass.sub('event')
      Piu::SubKlass2.sub('event')

      allow(SubKlass).to receive(:call)
      allow(Piu::SubKlass2).to receive(:call)
    end

    context 'when publish' do
      subject { PubKlass.pub('event', { message: 'published' }) }

      it 'calls SubKlass.call' do
        subject
        expect(SubKlass).to have_received(:call)
      end

      it 'calls Piu::SubKlass2.call' do
        PubKlass.new.publish
        expect(Piu::SubKlass2).to have_received(:call)
      end
    end

    context 'when unsub' do

      before { Piu::SubKlass2.unsub('event') }

      it 'calls SubKlass.call' do
        PubKlass.new.publish
        expect(SubKlass).to have_received(:call)
      end

      it 'calls Piu::SubKlass2.call' do
        PubKlass.new.publish
        expect(Piu::SubKlass2).not_to have_received(:call)
      end
    end
  end
end
