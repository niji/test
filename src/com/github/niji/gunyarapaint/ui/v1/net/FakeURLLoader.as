package com.github.niji.gunyarapaint.ui.v1.net
{
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    
    internal final class FakeURLLoader extends URLLoader
    {
        public function FakeURLLoader(request:URLRequest=null)
        {
            super(request);
        }
        
        public override function load(request:URLRequest):void
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
