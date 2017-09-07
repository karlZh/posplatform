package posscard


import org.junit.*
import grails.test.mixin.*

@TestFor(CardbinPlatformController)
@Mock(CardbinPlatform)
class CardbinPlatformControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/cardbinPlatform/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.cardbinPlatformInstanceList.size() == 0
        assert model.cardbinPlatformInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.cardbinPlatformInstance != null
    }

    void testSave() {
        controller.save()

        assert model.cardbinPlatformInstance != null
        assert view == '/cardbinPlatform/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/cardbinPlatform/show/1'
        assert controller.flash.message != null
        assert CardbinPlatform.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/cardbinPlatform/list'

        populateValidParams(params)
        def cardbinPlatform = new CardbinPlatform(params)

        assert cardbinPlatform.save() != null

        params.id = cardbinPlatform.id

        def model = controller.show()

        assert model.cardbinPlatformInstance == cardbinPlatform
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/cardbinPlatform/list'

        populateValidParams(params)
        def cardbinPlatform = new CardbinPlatform(params)

        assert cardbinPlatform.save() != null

        params.id = cardbinPlatform.id

        def model = controller.edit()

        assert model.cardbinPlatformInstance == cardbinPlatform
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/cardbinPlatform/list'

        response.reset()

        populateValidParams(params)
        def cardbinPlatform = new CardbinPlatform(params)

        assert cardbinPlatform.save() != null

        // test invalid parameters in update
        params.id = cardbinPlatform.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/cardbinPlatform/edit"
        assert model.cardbinPlatformInstance != null

        cardbinPlatform.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/cardbinPlatform/show/$cardbinPlatform.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        cardbinPlatform.clearErrors()

        populateValidParams(params)
        params.id = cardbinPlatform.id
        params.version = -1
        controller.update()

        assert view == "/cardbinPlatform/edit"
        assert model.cardbinPlatformInstance != null
        assert model.cardbinPlatformInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/cardbinPlatform/list'

        response.reset()

        populateValidParams(params)
        def cardbinPlatform = new CardbinPlatform(params)

        assert cardbinPlatform.save() != null
        assert CardbinPlatform.count() == 1

        params.id = cardbinPlatform.id

        controller.delete()

        assert CardbinPlatform.count() == 0
        assert CardbinPlatform.get(cardbinPlatform.id) == null
        assert response.redirectedUrl == '/cardbinPlatform/list'
    }
}
