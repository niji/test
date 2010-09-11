package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakePaintEngine;
    import com.github.niji.framework.commands.DrawCircleCommand;
    import com.github.niji.framework.commands.ICommand;

    public class DrawCircleCommandTest
    {
        [Test(description="円弧を描写するコマンドが正しく実行されること")]
        public function shouldExecuteCorrctly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new DrawCircleCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = {
                "radius": Math.PI
            };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[DrawCircleCommand radius=3.142]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(DrawCircleCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.radius, FakePaintEngine.radius);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
