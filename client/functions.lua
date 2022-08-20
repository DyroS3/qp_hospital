RegisterNetEvent("qp_hospital:hospitalMenu", function()
	local options = {}

	table.insert(options, {
		title = "Medical Treatment",
		description = "A procedure, or regimen, such as a drug, surgery, or exercise, in an attempt to cure or mitigate a disease, condition, or injury.",
		metadata = { "You will feel dizzy, and nauseous for a short period of time after the procedure." },
		event = "qp_hospital:requestTreatment",
	})

	table.insert(options, {
		title = "Need a bandage?",
		description = "Buy a strip of material used to bind a wound or to protect an injured part of the body.",
		metadata = { "This seems like a better idea, yea?" },
		event = "qp_hospital:requestBandage",
	})

	lib.registerContext({
		id = "hospital_menu",
		title = "Medical Center",
		options = options,
	})

	lib.showContext("hospital_menu")
end)

if config.utility.textui then
	local location = vector3(config.point.x, config.point.y, config.point.z)
	local point = lib.points.new(location, 1, {})

	function point:onEnter()
		lib.showTextUI("Press [E] to open the hospital menu")
	end

	function point:nearby()
		if self.currentDistance < 2 and IsControlJustReleased(0, 38) then
			TriggerEvent("qp_hospital:hospitalMenu")
		end

		function point:onExit()
			lib.hideTextUI()
		end
	end
elseif config.utility.ox_target then
	local ox_target = exports.ox_target
	ox_target:addSphereZone({
		coords = vec3(config.sphere.x, config.sphere.y, config.sphere.z),
		radius = 1,
		options = {
			{
				name = "sphere",
				event = "qp_hospital:hospitalMenu",
				icon = "fas fa-sign-in-alt",
				label = "Open Hospital Menu",
			},
		},
	})
end