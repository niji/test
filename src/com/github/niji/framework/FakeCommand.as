package com.github.niji.framework
{
    import com.github.niji.framework.commands.ICommand;
    
    import flash.utils.IDataInput;
    import flash.utils.IDataOutput;
	
	/**
	 * ICommand を実装したスタブクラス。実行したかのフラグを管理する
	 * 
	 */
    public class FakeCommand implements ICommand
    {
        public static const ID:int = 63;
        
        public function FakeCommand()
        {
            m_didExecute = false;
            m_didWrite = false;
            m_didRead = false;
            m_didReset = false;
            m_writeArgument = null;
        }
        
        public function read(bytes:IDataInput):void
        {
            m_didRead = true;
        }
        
        public function write(bytes:IDataOutput, args:Object):void
        {
            m_didWrite = true;
            m_writeArgument = args;
        }
        
        public function execute(painter:Painter):void
        {
            m_didExecute = true;
        }
        
        public function reset():void
        {
            m_didReset = true;
        }
        
        public function toString():String
        {
            return "[FakeCommand]";
        }
        
        public function get commandID():uint
        {
            return ID;
        }
        
        public function get didExecute():Boolean
        {
            return m_didExecute;
        }
        
        public function get didRead():Boolean
        {
            return m_didRead;
        }
        
        public function get didReset():Boolean
        {
            return m_didReset;
        }
        
        public function get didWrite():Boolean
        {
            return m_didWrite;
        }
        
        public function get writeArgument():Object
        {
            return m_writeArgument;
        }
        
        private var m_didExecute:Boolean;
        private var m_didRead:Boolean;
        private var m_didReset:Boolean;
        private var m_didWrite:Boolean;
        private var m_writeArgument:Object;
    }
}
