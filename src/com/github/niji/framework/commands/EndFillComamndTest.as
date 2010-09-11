package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakePaintEngine;
    import org.libspark.gunyarapaint.framework.commands.EndFillCommand;
    import org.libspark.gunyarapaint.framework.commands.ICommand;

    public class EndFillComamndTest
    {
        [Test(description="塗り終了コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new EndFillCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[EndFillCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(EndFillCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakePaintEngine.filled);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
