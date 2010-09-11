package com.github.niji.framework.commands
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import com.github.niji.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.commands.UndoCommand;

    public class UndoCommandTest
    {
        [Test(description="巻き戻しコマンドの実行")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new UndoCommand();
            var painter:FakePainter = new FakePainter();
            command.write(bytes, {});
            Assert.assertStrictlyEquals("[UndoCommand]", command.toString());
            bytes.position = 0;
            Assert.assertEquals(UndoCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertTrue(painter.didUndo);
        }
    }
}
