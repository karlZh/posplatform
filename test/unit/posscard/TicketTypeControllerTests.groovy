package posscard



import org.junit.*
import grails.test.mixin.*

@TestFor(TicketTypeController)
@Mock(TicketType)
class TicketTypeControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/ticketType/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.ticketTypeInstanceList.size() == 0
        assert model.ticketTypeInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.ticketTypeInstance != null
    }

    void testSave() {
        controller.save()

        assert model.ticketTypeInstance != null
        assert view == '/ticketType/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/ticketType/show/1'
        assert controller.flash.message != null
        assert TicketType.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/ticketType/list'

        populateValidParams(params)
        def ticketType = new TicketType(params)

        assert ticketType.save() != null

        params.id = ticketType.id

        def model = controller.show()

        assert model.ticketTypeInstance == ticketType
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/ticketType/list'

        populateValidParams(params)
        def ticketType = new TicketType(params)

        assert ticketType.save() != null

        params.id = ticketType.id

        def model = controller.edit()

        assert model.ticketTypeInstance == ticketType
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/ticketType/list'

        response.reset()

        populateValidParams(params)
        def ticketType = new TicketType(params)

        assert ticketType.save() != null

        // test invalid parameters in update
        params.id = ticketType.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/ticketType/edit"
        assert model.ticketTypeInstance != null

        ticketType.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/ticketType/show/$ticketType.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        ticketType.clearErrors()

        populateValidParams(params)
        params.id = ticketType.id
        params.version = -1
        controller.update()

        assert view == "/ticketType/edit"
        assert model.ticketTypeInstance != null
        assert model.ticketTypeInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/ticketType/list'

        response.reset()

        populateValidParams(params)
        def ticketType = new TicketType(params)

        assert ticketType.save() != null
        assert TicketType.count() == 1

        params.id = ticketType.id

        controller.delete()

        assert TicketType.count() == 0
        assert TicketType.get(ticketType.id) == null
        assert response.redirectedUrl == '/ticketType/list'
    }
}
