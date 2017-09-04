package posscard



import org.junit.*
import grails.test.mixin.*

@TestFor(CardPlatformController)
@Mock(CardPlatform)
class CardPlatformControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cardPlatform/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cardPlatformInstanceList.size() == 0
        assert model.cardPlatformInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cardPlatformInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cardPlatformInstance != null
        assert view == '/cardPlatform/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cardPlatform/show/1'
        assert controller.flash.message != null
        assert CardPlatform.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cardPlatform/list'

        populateValidParams(params)
        def cardPlatform = new CardPlatform(params)

        assert cardPlatform.save() != null

        params.id = cardPlatform.id

        def model = controller.show()

        assert model.cardPlatformInstance == cardPlatform
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cardPlatform/list'

        populateValidParams(params)
        def cardPlatform = new CardPlatform(params)

        assert cardPlatform.save() != null

        params.id = cardPlatform.id

        def model = controller.edit()

        assert model.cardPlatformInstance == cardPlatform
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cardPlatform/list'

        response.reset()

        populateValidParams(params)
        def cardPlatform = new CardPlatform(params)

        assert cardPlatform.save() != null

        // test invalid parameters in update
        params.id = cardPlatform.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cardPlatform/edit"
        assert model.cardPlatformInstance != null

        cardPlatform.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cardPlatform/show/$cardPlatform.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cardPlatform.clearErrors()

        populateValidParams(params)
        params.id = cardPlatform.id
        params.version = -1
        controller.update()

        assert view == "/cardPlatform/edit"
        assert model.cardPlatformInstance != null
        assert model.cardPlatformInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cardPlatform/list'

        response.reset()

        populateValidParams(params)
        def cardPlatform = new CardPlatform(params)

        assert cardPlatform.save() != null
        assert CardPlatform.count() == 1

        params.id = cardPlatform.id

        controller.delete()

        assert CardPlatform.count() == 0
        assert CardPlatform.get(cardPlatform.id) == null
        assert response.redirectedUrl == '/cardPlatform/list'
    }
}
