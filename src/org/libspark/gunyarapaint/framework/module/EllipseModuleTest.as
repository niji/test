package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.EllipseModule;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;

    public final class EllipseModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            var module:ICanvasModule = context.getModule(EllipseModule.ELLIPSE);
            Assert.assertTrue(module is EllipseModule);
            Assert.assertEquals(module.name, EllipseModule.ELLIPSE);
        }
    }
}
