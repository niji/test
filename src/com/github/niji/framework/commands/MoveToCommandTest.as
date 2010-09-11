package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import com.github.niji.framework.FakePaintEngine;
    import com.github.niji.framework.commands.MoveToCommand;

    public class MoveToCommandTest
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
        }
        
        private function assertCoordinates(x:int, y:int):void
        {
            var bytes:ByteArray = new ByteArray();
            var command:MoveToCommand = new MoveToCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "x": x, "y": y };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[MoveToCommand x=" + x + ", y=" + y + "]",
                command.toString()
            );
            bytes.position = 0;
            var byte:uint = bytes.readUnsignedByte();
            if (byte & 0x80 || byte & 0x40)
                command.compressedValue = byte;
            else
                Assert.assertEquals(MoveToCommand.ID, byte);
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.x, FakePaintEngine.point.x);
            Assert.assertEquals(args.y, FakePaintEngine.point.y);
        }
    }
}
