package org.libspark.gunyarapaint.framework
{
    import flash.utils.ByteArray;
    
    import org.libspark.gunyarapaint.framework.commands.ICommand;

    public class FakeCommand implements ICommand
    {
        public static const ID:int = 63;
        
        public function FakeCommand()
        {
            didExecute = false;
            didWrite = false;
            didRead = false;
            didReset = false;
            writeArgument = null;
        }
        
        public function read(bytes:ByteArray):void
        {
            didRead = true;
        }
        
        public function write(bytes:ByteArray, args:Object):void
        {
            didWrite = true;
            writeArgument = args;
        }
        
        public function execute(painter:Painter):void
        {
            didExecute = true;
        }
        
        public function reset():void
        {
            didReset = true;
        }
        
        public function toString():String
        {
            return "[FakeCommand]";
        }
        
        public function get commandID():uint
        {
            return ID;
        }
        
        public static var didExecute:Boolean;
        public static var didRead:Boolean;
        public static var didReset:Boolean;
        public static var didWrite:Boolean;
        public static var writeArgument:Object;
    }
}
