package com.github.niji.gunyarapaint.ui.v1.net
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;

    public class RequestTest
    {
        [Test(description="POST形式が期待通りの結果になること")]
        public function shouldPostExpectedly():void
        {
            var url:String = "http://localhost/path/to/post";
            var parameters:FakeParameters = new FakeParameters();
            var request:Request = newRequestFromURLLoader();
            request.post(url, parameters);
            var result:URLRequest = FakeURLLoader(request.loader).request;
            Assert.assertStrictlyEquals(url, result.url);
            Assert.assertStrictlyEquals(URLRequestMethod.POST, result.method);
            Assert.assertStrictlyEquals(Request.CONTENT_TYPE, result.contentType);
            Assert.assertTrue(ByteArray(result.data).readBoolean());
        }
        
        [Test(description="GET形式が期待通りの結果になること")]
        public function shouldGetExpectedly():void
        {
            var url:String = "http://localhost/path/to/get";
            var request:Request = newRequestFromURLLoader();
            request.get(url);
            var loader:FakeURLLoader = FakeURLLoader(request.loader);
            var result:URLRequest = loader.request;
            Assert.assertStrictlyEquals(url, result.url);
            Assert.assertStrictlyEquals(URLRequestMethod.GET, result.method);
            Assert.assertStrictlyEquals(URLLoaderDataFormat.BINARY, loader.dataFormat);
        }
        
        [Test(description="Loaderの要求が期待通りの結果になること")]
        public function shouldLoadExpectedly():void
        {
            var url:String = "http://localhost/path/to/get";
            var request:Request = newRequestFromLoader();
            request.load(url);
            var result:URLRequest = FakeLoader(LoaderInfo(request.loader).loader).request;
            Assert.assertStrictlyEquals(url, result.url);
        }
        
        [Test(expects="ArgumentError")]
        public function shouldAcceptOnlyLoaderOrURLLoader():void
        {
            var request:Request = newRequestFromURLLoader();
            request.loader = new DisplayObject();
        }
        
        private function newRequestFromURLLoader():Request
        {
            var request:Request = new Request();
            var loader:URLLoader = new FakeURLLoader();
            request.loader = loader;
            return request;
        }
        
        private function newRequestFromLoader():Request
        {
            var request:Request = new Request();
            var loader:Loader = new FakeLoader();
            request.loader = loader.contentLoaderInfo;
            return request;
        }
    }
}