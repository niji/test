package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.EraserModule;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public final class EraserModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = context.getModule(EraserModule.ERASER);
            Assert.assertTrue(module is EraserModule);
            Assert.assertEquals(module.name, EraserModule.ERASER);
        }
    }
}
