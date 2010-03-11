package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.DropperModule;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public final class DropperModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = context.getModule(DropperModule.DROPPER);
            Assert.assertTrue(module is DropperModule);
            Assert.assertEquals(module.name, DropperModule.DROPPER);
        }
    }
}
