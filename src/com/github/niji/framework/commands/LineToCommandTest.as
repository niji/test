package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.geom.Point;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class LineToCommandTest
    {
        [Test(description="xまたはyが7ビットを超えているなら圧縮しないこと")]
        public function shouldNotCompressIfArgsHasMoreThanSevenBits():void
        {
            assertCoordinates(64, -65);
            assertCoordinates(-65, 64);
        }
        
        [Test(description="xまたはyが7ビット以下であればshortに圧縮すること")]
        public function shouldCompressToShortIfArgsHasUnderSevenBits():void
        {
            assertCoordinates(63, -64);
            assertCoordinates(-64, 63);
            assertCoordinates(4, -5);
            assertCoordinates(-5, 4);
        }
        
        [Test(description="xまたはyが3ビット以下であればbyteに圧縮すること")]
        public function shouldCompressToByteIfArgsHasUnderThreeBits():void
        {
            assertCoordinates(3, -4);
            assertCoordinates(-4, 3);
        }
        
        private function assertCoordinates(x:int, y:int):void
        {
            var bytes:ByteArray = new ByteArray();
            var command:LineToCommand = new LineToCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "x": x, "y": y };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[LineToCommand x=" + x + ", y=" + y + "]",
                command.toString()
            );
            bytes.position = 0;
            var byte:uint = bytes.readUnsignedByte();
            if (byte & 0x80 || byte & 0x40)
                command.compressedValue = byte;
            else
                Assert.assertEquals(LineToCommand.ID, byte);
            command.read(bytes);
            command.execute(painter);
            var point:Point = painter.fakePaintEngine.point;
            Assert.assertEquals(args.x, point.x);
            Assert.assertEquals(args.y, point.y);
        }
    }
}
