package com.github.niji.framework.commands
{
    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePaintEngine;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.commands.ICommand;
    import com.github.niji.framework.commands.PenCommand;

    public class PenCommandTest
    {
        [Test(description="ペンの太さが正しく変更されること")]
        public function shouldChangeThicknessCorrectly():void
        {
            test(PenCommand.THICKNESS, "thickness", 42);
        }
        
        [Test(description="ペンの色が正しく変更されること")]
        public function shouldChangeColorCorrectly():void
        {
            test(PenCommand.COLOR, "color", 0xffffffff);
        }
        
        [Test(description="ペンの不透明度が正しく変更されること")]
        public function shouldChangeAlphaCorrectly():void
        {
            test(PenCommand.ALPHA, "alpha", 0.314);
        }
        
        [Test(description="ペンのマイター値が正しく変更されること")]
        public function shouldChangeMiterLimitCorrectly():void
        {
            test(PenCommand.MITER_LIMIT, "miterLimit", 0.314);
        }
        
        [Test(description="ペンのスケールモードが正しく変更されること")]
        public function shouldChangeScaleModeCorrectly():void
        {
            test(PenCommand.SCALE_MODE, "scaleMode", LineScaleMode.VERTICAL);
        }
        
        [Test(description="ペンのキャップモードが正しく変更されること")]
        public function shouldChangeCapsStyleCorrectly():void
        {
            test(PenCommand.CAPS, "capsStyle", CapsStyle.SQUARE);
        }
        
        [Test(description="ペンのジョイントを調整")]
        public function shouldChangeJointStyleCorrectly():void
        {
            test(PenCommand.JOINTS, "jointStyle", JointStyle.BEVEL);
        }
        
        [Test(description="ペンのピクセルヒンティングを調整")]
        public function shouldChangePixelHintingCorrectly():void
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
