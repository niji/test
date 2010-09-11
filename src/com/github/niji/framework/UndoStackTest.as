package com.github.niji.framework
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.LayerCollection;
    import org.libspark.gunyarapaint.framework.UndoStack;

    public class UndoStackTest
    {
        [Test(description="UndoStackの情報を保存して後から読み込んで復元出来ること")]
        public function shouldUndoStackIsAbleToRestoreAfterSaving():void
        {
            var layers:LayerCollection = new LayerCollection(100, 100);
            var undo:UndoStack = new UndoStack(layers);
            for (var i:uint = 0; i < 4; i++) {
                undo.push(layers);
                undo.push(layers);
                undo.undo(layers);
                undo.redo(layers);
            }
            var data:Object = {};
            undo.save(data);
            Assert.assertEquals(8, data.index);
            Assert.assertEquals(data.index, data.last);
            Assert.assertEquals(0, data.first);
            Assert.assertEquals(9, data.data.length);
            var bytes:ByteArray = new ByteArray();
            bytes.writeObject(data);
            // ((((100 * 100) * 4) * 1) * 9)
            Assert.assertTrue(bytes.length > 360000);
            var undo2:UndoStack = new UndoStack(layers);
            undo2.load(data);
            Assert.assertEquals(undo.undoCount, undo2.undoCount);
            Assert.assertEquals(undo.redoCount, undo2.redoCount);
        }
        
        [Test(description="UndoStack#saveを2回呼び出しても例外が発生しないこと")]
        public function shouldNotThrowExceptionAfterSaveTwice():void
        {
            var layers:LayerCollection = new LayerCollection(100, 100);
            var undo:UndoStack = new UndoStack(layers);
            var data:Object = {};
            undo.save(data);
            try {
                var data2:Object = {};
                undo.save(data2);
            } catch (e:Error) {
                Assert.fail(e.getStackTrace());
            }
        }
    }
}
