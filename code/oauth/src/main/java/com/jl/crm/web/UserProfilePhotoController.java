package com.jl.crm.web;

import com.jl.crm.services.*;
import org.springframework.hateoas.*;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import java.net.URI;

@Controller
@RequestMapping (value = "/users/{userId}/photo")
public class UserProfilePhotoController {

	private CrmService crmService;
	private UserLinks userLinks;

	@Inject
	void setCrmService(CrmService crmService) {
		this.crmService = crmService;
	}

	@Inject
	void setUserLinks(UserLinks userLinks) {
		this.userLinks = userLinks;
	}

	@RequestMapping (method = RequestMethod.POST)
	HttpEntity<Void> writeUserProfilePhoto(@PathVariable Long userId, @RequestParam MultipartFile file) throws Throwable {
		if (userId == null){
			throw new UserProfilePhotoWriteException(null, new RuntimeException("you need to specify a valid user ID#"));
		}
		User user = this.crmService.findById(userId);
		byte[] bytesForProfilePhoto = FileCopyUtils.copyToByteArray(file.getInputStream());
		this.crmService.writeUserProfilePhoto(user.getId(), MediaType.parseMediaType(file.getContentType()), bytesForProfilePhoto);

		Link photoLink = this.userLinks.getPhotoLink(user);
		Link userLink = this.userLinks.getSelfLink(user);
		Links wrapperOfLinks = new Links(photoLink, userLink);

		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.add("Link", wrapperOfLinks.toString());  // we can't encode the links in the body of the response, so we put them in the "Links:" header.
		httpHeaders.setLocation(URI.create(photoLink.getHref())); // "Location: /users/{userId}/photo"

		return new ResponseEntity<Void>(httpHeaders, HttpStatus.ACCEPTED);
	}

	@RequestMapping (method = RequestMethod.GET)
	HttpEntity<byte[]> loadUserProfilePhoto(@PathVariable Long userId) throws Throwable {
		CrmService.ProfilePhoto profilePhoto;
		User user = this.crmService.findById(userId);
		if (null != user && (profilePhoto = this.crmService.readUserProfilePhoto(user.getId())) != null){
			HttpHeaders httpHeaders = new HttpHeaders();
			httpHeaders.setContentType(profilePhoto.getMediaType());
			return new ResponseEntity<byte[]>(profilePhoto.getPhoto(), httpHeaders, HttpStatus.OK);
		}
		else {
			throw new UserProfilePhotoReadException(-1, new RuntimeException("couldn't find the user"));
		}
	}


}