package org.springframework.samples.petclinic.cause;

import org.springframework.beans.factory.annotation.Autowired;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

@Controller
public class CauseController {

	private final CauseService causeService;

	private static final String VIEWS_CAUSE_CREATE_FORM = "causes/createCauseForm";

	@Autowired
	public CauseController(CauseService causeService) {
		this.causeService = causeService;
		
	}

	@GetMapping(value = {"/causes"})
	public String showCauseList(Map<String, Object> model) {
		List<Cause> c = this.causeService.findAllCauses();
		model.put("causes", c);
		return "causes/causeList";
	}
	@GetMapping(value = "/causes/new")
	public String initCreationForm(Map<String, Object> model) {
		var cause = new Cause();
		model.put("cause", cause);
		return VIEWS_CAUSE_CREATE_FORM;
	}
	@PostMapping(value = "/causes/new")
	public String processCreationForm(RedirectAttributes redirect, HttpSession session,@Valid Cause cause, BindingResult result) {
		if (result.hasErrors()) {
			return VIEWS_CAUSE_CREATE_FORM;
		}else if(cause.getBudgetTarget() <= 0){
			result.rejectValue("budgetTarget", "negativeNumber", "el presupuesto objetivo no puede ser negativo o nulo");
			return VIEWS_CAUSE_CREATE_FORM;
		}else {
			this.causeService.saveCause(cause);
			return "redirect:/causes";
		}
	}

	
	@GetMapping("/causes/detail/{causeId}")
	public ModelAndView showCauseDetails(@PathVariable("causeId") int causeId) {
		var mav = new ModelAndView("/causes/causeDetails");
		mav.addObject(this.causeService.findCauseById(causeId));
		mav.addObject(this.causeService.findDonationsByCauseId(causeId));
		return mav;
	}

}



