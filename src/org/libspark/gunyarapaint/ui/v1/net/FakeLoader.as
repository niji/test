package org.libspark.gunyarapaint.ui.v1.net
{
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.system.LoaderContext;
    
    internal final class FakeLoader extends Loader
    {
        public function FakeLoader()
        {
            super();
        }
        
        public override function load(request:URLRequest, context:LoaderContext=null):void
        {
            m_request = request;
        }
        
        public function get request():URLRequest
        {
            return m_request;
        }
        
        private var m_request:URLRequest;
    }
}
