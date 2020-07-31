RSpec.describe EmbedCallbacks do
  it "has a version number" do
    expect(EmbedCallbacks::VERSION).not_to be nil
  end

  context 'before callback' do
    class BeforeCallbackClass
      include EmbedCallbacks

      attr_accessor :buffer

      set_callback :target1, :before, :callback1
      set_callback :target2, :before, :callback1
      set_callback :target2, :before, :callback2

      def initialize
        @buffer = ''
      end

      def target1
        @buffer += 'target1'
      end

      def target2(arg)
        @buffer += 'target2' + arg
      end

      private

      def callback1
        @buffer += 'callback1'
      end

      def callback2
        @buffer += 'callback2'
      end
    end

    it "before callback" do
      callback = BeforeCallbackClass.new
      callback.target1
      expect('callback1target1').to eq(callback.buffer)
    end

    it "before multi callback" do
      callback = BeforeCallbackClass.new
      callback.target2('test')
      expect('callback2callback1target2test').to eq(callback.buffer)
    end
  end

  context 'after callback' do
    class AfterCallbackClass
      include EmbedCallbacks
      attr_accessor :buffer

      set_callback :target1, :after, :callback1
      set_callback :target2, :after, :callback1
      set_callback :target2, :after, :callback2

      def initialize
        @buffer = ''
      end

      def target1
        @buffer += 'target1'
      end

      def target2(arg)
        @buffer += 'target2' + arg
      end

      private

      def callback1
        @buffer += 'callback1'
      end

      def callback2
        @buffer += 'callback2'
      end
    end

    it "after callback" do
      callback = AfterCallbackClass.new
      callback.target1
      expect('target1callback1').to eq(callback.buffer)
    end

    it "after multi callback" do
      callback = AfterCallbackClass.new
      callback.target2('test')
      expect('target2testcallback1callback2').to eq(callback.buffer)
    end
  end

  context 'around callback' do
    class AroundCallbackClass
      include EmbedCallbacks
      attr_accessor :buffer

      set_callback :target1, :around, :callback1
      set_callback :target2, :around, :callback1
      set_callback :target2, :around, :callback2

      def initialize
        @buffer = ''
      end

      def target1
        @buffer += 'target1'
      end

      def target2(arg)
        @buffer += 'target2' + arg
      end

      private

      def callback1
        @buffer += 'callback1'
      end

      def callback2
        @buffer += 'callback2'
      end
    end

    it "around callback" do
      callback = AroundCallbackClass.new
      callback.target1
      expect('callback1target1callback1').to eq(callback.buffer)
    end

    it "around multi callback" do
      callback = AroundCallbackClass.new
      callback.target2('test')
      expect('callback2callback1target2testcallback1callback2').to eq(callback.buffer)
    end
  end
end
