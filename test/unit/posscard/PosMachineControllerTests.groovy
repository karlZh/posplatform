package posscard



import org.junit.*
import grails.test.mixin.*

@TestFor(PosMachineController)
@Mock(PosMachine)
class PosMachineControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/posMachine/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.posMachineInstanceList.size() == 0
        assert model.posMachineInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.posMachineInstance != null
    }

    void testSave() {
        controller.save()

        assert model.posMachineInstance != null
        assert view == '/posMachine/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/posMachine/show/1'
        assert controller.flash.message != null
        assert PosMachine.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/posMachine/list'

        populateValidParams(params)
        def posMachine = new PosMachine(params)

        assert posMachine.save() != null

        params.id = posMachine.id

        def model = controller.show()

        assert model.posMachineInstance == posMachine
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/posMachine/list'

        populateValidParams(params)
        def posMachine = new PosMachine(params)

        assert posMachine.save() != null

        params.id = posMachine.id

        def model = controller.edit()

        assert model.posMachineInstance == posMachine
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/posMachine/list'

        response.reset()

        populateValidParams(params)
        def posMachine = new PosMachine(params)

        assert posMachine.save() != null

        // test invalid parameters in update
        params.id = posMachine.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/posMachine/edit"
        assert model.posMachineInstance != null

        posMachine.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/posMachine/show/$posMachine.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        posMachine.clearErrors()

        populateValidParams(params)
        params.id = posMachine.id
        params.version = -1
        controller.update()

        assert view == "/posMachine/edit"
        assert model.posMachineInstance != null
        assert model.posMachineInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/posMachine/list'

        response.reset()

        populateValidParams(params)
        def posMachine = new PosMachine(params)

        assert posMachine.save() != null
        assert PosMachine.count() == 1

        params.id = posMachine.id

        controller.delete()

        assert PosMachine.count() == 0
        assert PosMachine.get(posMachine.id) == null
        assert response.redirectedUrl == '/posMachine/list'
    }
}
