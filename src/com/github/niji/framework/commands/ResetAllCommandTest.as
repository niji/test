package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class ResetAllCommandTest
    {
        [Test(description="初期化コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new ResetAllCommand();
            var move:ICommand = new MoveToCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            move.write(bytes, { "x": 12345, "y": -12345 });
            Assert.assertStrictlyEquals("[ResetAllCommand]", command.toString());
            Assert.assertStrictlyEquals("[MoveToCommand x=12345, y=-12345]", move.toString());
            bytes.position = 0;
            Assert.assertEquals(ResetAllCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertStrictlyEquals("[MoveToCommand x=0, y=0]", move.toString());
        }
    }
}
