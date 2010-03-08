package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.FloodFillCommand;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.FakeCanvasContext;
    import org.libspark.gunyarapaint.framework.FakeCanvasContext;

    public class FloodFillCommandTest
    {
        [Test]
        public function 塗りつぶしコマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new FloodFillCommand();
            var canvas:FakeCanvasContext = new FakeCanvasContext();
            command.write(bytes, {});
            bytes.position = 0;
            Assert.assertEquals(FloodFillCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(canvas);
            Assert.assertTrue(FakeCanvasContext.didFloodFill);
            Assert.assertTrue(FakeCanvasContext.didEndDrawing);
            Assert.assertTrue(canvas.didPushUndo);
        }
    }
}