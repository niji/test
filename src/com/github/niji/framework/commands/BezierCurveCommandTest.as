package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.commands.BezierCurveCommand;
    import org.libspark.gunyarapaint.framework.commands.ICommand;

    public final class BezierCurveCommandTest
    {
        [Ignore]
        [Test(description="ベジエ曲線描写コマンドが正しく実行されること")]
        public function shouldExecuteCorrectly():void
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
            Assert.assertStrictlyEquals(
                "[BezierCurveCommand anchorX=32, anchorY=24, controlX=16, controlY=8]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(BezierCurveCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            // TODO: implement this
        }
    }
}
