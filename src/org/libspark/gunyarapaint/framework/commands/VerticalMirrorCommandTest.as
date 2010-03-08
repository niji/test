package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.VerticalMirrorCommand;
    import org.libspark.gunyarapaint.framework.FakeCanvasContext;
    import org.libspark.gunyarapaint.framework.FakeCanvasContext;

    public class VerticalMirrorCommandTest
    {
        [Test]
        public function 垂直ミラー作成コマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new VerticalMirrorCommand();
            var canvas:FakeCanvasContext = new FakeCanvasContext();
            var args:Object = { "index": 42 };
            command.write(bytes, args);
            bytes.position = 0;
            Assert.assertEquals(VerticalMirrorCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(canvas);
            Assert.assertEquals(args.index, FakeCanvasContext.layerIndex);
            Assert.assertFalse(canvas.didPushUndo);
        }
    }
}