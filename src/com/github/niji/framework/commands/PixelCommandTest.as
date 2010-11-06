package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.geom.Point;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class PixelCommandTest
    {
        [Test(description="ピクセルコマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new PixelCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "x": 1234, "y": 4321 };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[PixelCommand x=1234, y=4321]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(PixelCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            var point:Point = painter.point;
            Assert.assertEquals(args.x, point.x);
            Assert.assertEquals(args.y, point.y);
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
