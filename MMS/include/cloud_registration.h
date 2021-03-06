#ifndef CLOUD_REGISTRATION_H
#define CLOUD_REGISTRATION_H

#include "cloud_geometry.h"
#include "common_use.h"

struct TrVisitorType 
{
	template <typename Derived>
	inline void operator() (float fraction, float best_LCP, const Eigen::MatrixBase<Derived>& transformation)
	{
		if (fraction >= 0)
		{
			std::cout << "done: " << (fraction * 100) << "% best " << best_LCP << "\n";
		}
	}
	constexpr bool needsGlobalTransformation() const { return false; }
};

class cloud_registration
{
public:
	cloud_registration();

	~cloud_registration();

	//! TODO, need to know more about this method
	/* 
	result matrix should be applied to points2
	points21>points2
	*/
	void coarse_registration(std::vector<point_3d> & points1, std::vector<point_3d> &points2, Eigen::Matrix4f & ret_mat, const std::string & coarse_configuration);

	//! TODO, create a custom ICP algorithm
	/*
	result matrix should be applied to points2
	points1->points2
	*/
	void fine_registration(std::vector<point_3d> & points1, std::vector<point_3d> &points2, const std::string & configuration_file_name, Eigen::Matrix4f & ret_mat);

};

#endif // !CLOUD_REGISTRATION_H

