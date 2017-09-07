package posscard


import org.junit.*
import grails.test.mixin.*

@TestFor(CardBinController)
@Mock(CardBin)
class CardBinControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cardBin/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cardBinInstanceList.size() == 0
        assert model.cardBinInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cardBinInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cardBinInstance != null
        assert view == '/cardBin/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cardBin/show/1'
        assert controller.flash.message != null
        assert CardBin.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cardBin/list'

        populateValidParams(params)
        def cardBin = new CardBin(params)

        assert cardBin.save() != null

        params.id = cardBin.id

        def model = controller.show()

        assert model.cardBinInstance == cardBin
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cardBin/list'

        populateValidParams(params)
        def cardBin = new CardBin(params)

        assert cardBin.save() != null

        params.id = cardBin.id

        def model = controller.edit()

        assert model.cardBinInstance == cardBin
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cardBin/list'

        response.reset()

        populateValidParams(params)
        def cardBin = new CardBin(params)

        assert cardBin.save() != null

        // test invalid parameters in update
        params.id = cardBin.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cardBin/edit"
        assert model.cardBinInstance != null

        cardBin.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cardBin/show/$cardBin.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cardBin.clearErrors()

        populateValidParams(params)
        params.id = cardBin.id
        params.version = -1
        controller.update()

        assert view == "/cardBin/edit"
        assert model.cardBinInstance != null
        assert model.cardBinInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cardBin/list'

        response.reset()

        populateValidParams(params)
        def cardBin = new CardBin(params)

        assert cardBin.save() != null
        assert CardBin.count() == 1

        params.id = cardBin.id

        controller.delete()

        assert CardBin.count() == 0
        assert CardBin.get(cardBin.id) == null
        assert response.redirectedUrl == '/cardBin/list'
    }
}
