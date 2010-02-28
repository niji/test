package org.libspark.gunyarapaint.framework.module
{
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public class RectModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = new Recorder();
            var module:IDrawable = DrawModuleFactory.create(DrawModuleFactory.RECT, recorder);
            Assert.assertEquals(module.name, DrawModuleFactory.RECT);
        }
    }
}
