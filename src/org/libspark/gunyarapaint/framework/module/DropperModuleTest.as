package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.CanvasModuleContext;
    import org.libspark.gunyarapaint.framework.modules.DropperModule;
    import org.libspark.gunyarapaint.framework.modules.ICanvasModule;

    public final class DropperModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:CanvasModuleContext = new CanvasModuleContext(recorder);
            var module:ICanvasModule = context.getModule(DropperModule.DROPPER);
            Assert.assertTrue(module is DropperModule);
            Assert.assertEquals(module.name, DropperModule.DROPPER);
        }
    }
}
