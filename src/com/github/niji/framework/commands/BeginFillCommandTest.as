package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class BeginFillCommandTest
    {
        [Test(description="塗り開始コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var args:Object = {
                "color": 0xffffff,
                "alpha": 1.0
            };
            var command:ICommand = new BeginFillCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[BeginFillCommand alpha=1.000, color=0xffffff]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(BeginFillCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.alpha, painter.fakePaintEngine.alpha);
            Assert.assertEquals(args.color, painter.fakePaintEngine.color);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
