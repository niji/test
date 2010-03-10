package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.EllipseModule;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public final class EllipseModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var factory:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = factory.create(EllipseModule.ELLIPSE);
            Assert.assertTrue(module is EllipseModule);
            Assert.assertEquals(module.name, EllipseModule.ELLIPSE);
        }
    }
}
