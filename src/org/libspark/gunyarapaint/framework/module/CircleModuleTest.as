package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.CircleModule;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;

    public final class CircleModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            var module:ICanvasModule = context.getModule(CircleModule.CIRCLE);
            Assert.assertTrue(module is CircleModule);
            Assert.assertEquals(module.name, CircleModule.CIRCLE);
        }
    }
}
