package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePainter;

    public final class BezierCurveCommandTest
    {
        [Test]
        public function ベジエ曲線描写コマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var args:Object = {
                "anchorX": 32,
                "anchorY": 24,
                "controlX": 16,
                "controlY": 8
            };
            var command:ICommand = new BezierCurveCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, args);
            bytes.position = 0;
            Assert.assertEquals(BezierCurveCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            // TODO: implement this
        }
    }
}
