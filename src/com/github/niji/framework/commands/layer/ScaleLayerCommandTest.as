package com.github.niji.framework.commands.layer
{
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.ICommand;
    
    import flash.geom.Point;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public final class ScaleLayerCommandTest
    {
        [Test(description="レイヤー拡大縮小コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new ScaleLayerCommand();
            var painter:FakePainter = new FakePainter();
            var point:Point = new Point(63, -64);
            var args:Object = { "x": point.x, "y": point.y };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[ScaleLayerCommand x=63, y=-64]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(ScaleLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(point.equals(painter.point));
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
