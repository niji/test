package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.CompositeCommand;
    import com.github.niji.framework.commands.ICommand;

    public class CompositeCommandTest
    {
        [Test(description="描写コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new CompositeCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[CompositeCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(CompositeCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakePainter.didComposite);
            Assert.assertTrue(FakePainter.didEndDrawing);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
