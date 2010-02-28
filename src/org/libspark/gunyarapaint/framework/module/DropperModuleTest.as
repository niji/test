package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public final class DropperModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = new Recorder();
            var module:IDrawable = DrawModuleFactory.create(DrawModuleFactory.DROPPER, recorder);
            Assert.assertEquals(module.name, DrawModuleFactory.DROPPER);
        }
    }
}
