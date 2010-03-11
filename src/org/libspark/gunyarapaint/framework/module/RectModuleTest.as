package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;
    import org.libspark.gunyarapaint.framework.modules.RectModule;

    public class RectModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = Recorder.create(1, 1, 1);
            var context:DrawModuleFactory = new DrawModuleFactory(recorder);
            var module:IDrawable = context.getModule(RectModule.RECT);
            Assert.assertTrue(module is RectModule);
            Assert.assertEquals(module.name, RectModule.RECT);
        }
    }
}
