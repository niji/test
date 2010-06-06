package org.libspark.gunyarapaint.framework.module
{
    import flash.errors.IllegalOperationError;
    import flash.geom.Point;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.FakePainter;
    import org.libspark.gunyarapaint.framework.Parser;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.commands.ICommand;
    import org.libspark.gunyarapaint.framework.modules.CanvasModule;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;

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
        
        public static function assertCommands(expected:uint, bytes:ByteArray):void
        {
            Assert.assertEquals(expected, getCommands(bytes).length);
        }
        
        public static function assertLineSegment(module:ICanvasModule, checkStart:Boolean):void
        {
            var start:Point = new Point();
            var end:Point = new Point();
            module.start(12, 34);
            module.stop(56, 78);
            CanvasModule(module).getLineSegment(start, end);
            if (checkStart) {
                Assert.assertEquals(start.x, 12);
                Assert.assertEquals(start.y, 34);
            }
            Assert.assertEquals(end.x, 56);
            Assert.assertEquals(end.y, 78);
        }
    }
}
