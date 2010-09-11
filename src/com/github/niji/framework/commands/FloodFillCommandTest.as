package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.FloodFillCommand;
    import com.github.niji.framework.commands.ICommand;

    public class FloodFillCommandTest
    {
        [Test(description="塗りつぶしコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new FloodFillCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[FloodFillCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(FloodFillCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakePainter.didFloodFill);
            Assert.assertTrue(FakePainter.didEndDrawing);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
