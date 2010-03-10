package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;
    import org.libspark.gunyarapaint.framework.modules.PixelModule;

    public class PixelModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var factory:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = factory.create(PixelModule.PIXEL);
            Assert.assertTrue(module is PixelModule);
            Assert.assertEquals(module.name, PixelModule.PIXEL);
        }
    }
}
