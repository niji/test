package org.libspark.gunyarapaint.framework.module
{
    import flash.errors.IllegalOperationError;
    import flash.utils.ByteArray;
    
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.Parser;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.commands.ICommand;

    internal final class ModuleTestUtil
    {
        public function ModuleTestUtil()
        {
            throw new IllegalOperationError();
        }
        
        public static function createRecorder(bytes:ByteArray):Recorder
        {
            return Recorder.create(bytes, 100, 100, 1);
        }
        
        public static function getCommands(bytes:ByteArray):Vector.<ICommand>
        {
            var commands:Vector.<ICommand> = new Vector.<ICommand>();
            try {
                var painter:FakePainter = new FakePainter();
                var data:Object = {};
                var parser:Parser = new Parser(bytes);
                parser.readHeader(data);
                while (true) {
                    var command:ICommand = parser.parse();
                    command.read(bytes);
                    command.execute(painter);
                    commands.push(command);
                }
            } catch (e:Error) {
            }
            return commands;
        }
    }
}
