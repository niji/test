package org.libspark.gunyarapaint.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.UndoCommand;
    import org.libspark.gunyarapaint.framework.FakePainter;

    public class UndoCommandTest
    {
        [Test]
        public function 巻き戻しコマンドの実行():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new UndoCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            bytes.position = 0;
            Assert.assertEquals(UndoCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(painter.didUndo);
        }
    }
}