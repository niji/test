package com.github.niji.framework.commands
{
    import com.github.niji.framework.FakePainter;
    
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class VerticalMirrorCommandTest
    {
        [Test(description="垂直ミラー作成コマンドの実行")]
        public function shouldExecuteCorrectly():void
        {
            var bytes:ByteArray = new ByteArray();
            var command:ICommand = new VerticalMirrorCommand();
            var painter:FakePainter = new FakePainter();
            var args:Object = { "index": 42 };
            command.write(bytes, args);
            Assert.assertStrictlyEquals(
                "[VerticalMirrorCommand index=42]",
                command.toString()
            );
            bytes.position = 0;
            Assert.assertEquals(VerticalMirrorCommand.ID, bytes.readByte());
            command.read(bytes);
            command.execute(painter);
            Assert.assertEquals(args.index, painter.layerIndex);
            Assert.assertFalse(painter.didPushUndo);
        }
    }
}
