package org.libspark.gunyarapaint.ui.v1
{
    import org.libspark.gunyarapaint.framework.ui.IApplication;
    import org.libspark.gunyarapaint.framework.ui.IController;
    
    public final class FakeController implements IController
    {
        public function FakeController()
        {
            // do nothing
        }
        
        public function init(app:IApplication):void
        {
            // do nothing
        }
        
        public function load(data:Object):void
        {
            m_data = data.key;
        }
        
        public function save(data:Object):void
        {
            data.key = name;
        }
        
        public function resetWindow():void
        {
            // do nothing
        }
        
        public function get name():String
        {
            return "fake";
        }
        
        public function get value():String
        {
            return m_data;
        }
        
        private var m_data:String;
    }
}