package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.EndFillCommand;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.FakePaintEngine;

    public class EndFillComamndTest
    {
        [Test]
        public function 塗り終了コマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new EndFillCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            bytes.position = 0;
            Assert.assertEquals(EndFillCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(FakePaintEngine.filled);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}