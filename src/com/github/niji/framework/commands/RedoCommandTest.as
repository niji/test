package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.RedoCommand;

    public class RedoCommandTest
    {
        [Test(description="やり直しコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new RedoCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[RedoCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(RedoCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(painter.didRedo);
        }
    }
}
