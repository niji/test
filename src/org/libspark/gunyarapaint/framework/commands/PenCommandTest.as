package org.libspark.gunyarapaint.framework.commands
{
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePaintEngine;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.PenCommand;

    public class PenCommandTest
    {
        [Test]
        public function ペンの太さを調整():void
        {
            test(PenCommand.THICKNESS, "thickness", 42);
        }
        
        [Test]
        public function ペンの色を調整():void
        {
            test(PenCommand.COLOR, "color", 0xffffffff);
        }
        
        [Test]
        public function ペンの透明度を調整():void
        {
            test(PenCommand.ALPHA, "alpha", 0.314);
        }
        
        [Test]
        public function ペンのマイター値を調整():void
        {
            test(PenCommand.MITER_LIMIT, "miterLimit", 0.314);
        }
        
        [Test]
        public function ペンのスケールモードを調整():void
        {
            test(PenCommand.SCALE_MODE, "scaleMode", LineScaleMode.VERTICAL);
        }
        
        [Test]
        public function ペンのキャップを調整():void
        {
            test(PenCommand.CAPS, "capsStyle", CapsStyle.SQUARE);
        }
        
        [Test]
        public function ペンのジョイントを調整():void
        {
            test(PenCommand.JOINTS, "jointStyle", JointStyle.BEVEL);
        }
        
        [Test]
        public function ペンのピクセルヒンティングを調整():void
        {
            test(PenCommand.PIXEL_HINTING, "pixelHinting", false);
        }
        
        private function test(type:uint, key:String, value:*):void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new PenCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "type": type };
            args[key] = value;
            command.write(bytes, args);
            // ugly
            if (value == 0xffffffff)
                value = "0xffffffff";
            else if (value is Number && value != 42)
                value = value.toPrecision(4);
            Assert.assertStrictlyEquals(
                "[PenCommand " + key + "=" + value + "]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(PenCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args[key], FakePainter.fakePaintEngine.pen[key]);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
