package org.libspark.gunyarapaint.framework.commands.layer
{
    import flash.geom.Point;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.commands.ICommand;

    public final class MoveLayerCommandTest
    {
        [Test(description="レイヤー移動コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new MoveLayerCommand();
            var painter:FakePainter = new FakePainter();
            var point:Point = new Point(63, -64);
            var args:Object = { "x": point.x, "y": point.y };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[MoveLayerCommand x=63, y=-64]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(MoveLayerCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(point.equals(FakePainter.coordinate));
            Assert.assertTrue(painter.didPushUndo);
        }
    }
}
