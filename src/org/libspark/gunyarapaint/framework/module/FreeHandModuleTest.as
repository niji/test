package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.FreeHandModule;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public class FreeHandModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var factory:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = factory.create(FreeHandModule.FREE_HAND);
            Assert.assertTrue(module is FreeHandModule);
            Assert.assertEquals(module.name, FreeHandModule.FREE_HAND);
        }
    }
}
