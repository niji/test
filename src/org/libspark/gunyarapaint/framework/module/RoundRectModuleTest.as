package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;
    import org.libspark.gunyarapaint.framework.modules.RoundRectModule;

    public class RoundRectModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            var module:ICanvasModule = context.getModule(RoundRectModule.ROUND_RECT);
            Assert.assertTrue(module is RoundRectModule);
            Assert.assertEquals(module.name, RoundRectModule.ROUND_RECT);
        }
    }
}
